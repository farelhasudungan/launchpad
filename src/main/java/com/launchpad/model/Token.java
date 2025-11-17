package com.launchpad.model;

public class Token {
    private Long id;
    private String name;
    private String symbol;
    private String network;
    private byte[] imageData; // Stores image bytes
    private String imageType; // MIME type
    private String contractAddress; // NEW: Blockchain contract address
    private String transactionHash;  // NEW: Deployment transaction hash
    private String deployerAddress;  // NEW: Who deployed it

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getSymbol() { return symbol; }
    public void setSymbol(String symbol) { this.symbol = symbol; }
    
    public String getNetwork() { return network; }
    public void setNetwork(String network) { this.network = network; }
    
    public byte[] getImageData() { return imageData; }
    public void setImageData(byte[] imageData) { this.imageData = imageData; }
    
    public String getImageType() { return imageType; }
    public void setImageType(String imageType) { this.imageType = imageType; }

    public String getContractAddress() { return contractAddress; }
    public void setContractAddress(String contractAddress) { this.contractAddress = contractAddress; }
    
    public String getTransactionHash() { return transactionHash; }
    public void setTransactionHash(String transactionHash) { this.transactionHash = transactionHash; }
    
    public String getDeployerAddress() { return deployerAddress; }
    public void setDeployerAddress(String deployerAddress) { this.deployerAddress = deployerAddress; }
}
