module plsm_token::plsm_token {
    use std::option;

    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use sui::url;

    struct PLSM_TOKEN has drop {}

    fun init(witness: PLSM_TOKEN, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency<PLSM_TOKEN>(witness,
            9,
            b"PLSM",
            b"PLSM",
            b"PLSM is the native token of Plasmaverse: Multi-Phase ARPG Game on Metaverse  in Sui Network",
            option::some(url::new_unsafe_from_bytes(b"https://ipfs.thirdwebcdn.com/ipfs/Qmbf9KikVv1ApYhWyhTXo64CuDVF15XepM5qDxBNcwBcVU")),
            ctx);

        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx))
    }

    public entry fun mint(
        treasury_cap: &mut TreasuryCap<PLSM_TOKEN>, amount: u64, recipient: address, ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx)
    }

    public entry fun burn(treasury_cap: &mut TreasuryCap<PLSM_TOKEN>, coin: Coin<PLSM_TOKEN>) {
        coin::burn(treasury_cap, coin);
    }
}