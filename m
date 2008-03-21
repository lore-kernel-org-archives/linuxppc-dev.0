Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 6C5EDDDDFD
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 16:09:43 +1100 (EST)
Date: Fri, 21 Mar 2008 01:09:41 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: DTS question
Message-ID: <20080321010941.5e4bf9d4@lappy.seanm.ca>
In-Reply-To: <fa686aa40803202134p7db6a106n8487aa0040b5990c@mail.gmail.com>
References: <20080320173302.7075a1d9@lappy.seanm.ca>
	<20080320181926.2ff7e297@lappy.seanm.ca>
	<47E2E4A2.9000801@freescale.com>
	<20080321001236.4e37bba4@lappy.seanm.ca>
	<fa686aa40803202134p7db6a106n8487aa0040b5990c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 20 Mar 2008 22:34:21 -0600
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> Convention is to use the stock ticker symbol.  If the company is
> private and has no stock ticker symbol, then the company name should
> be used.

I didn't know that. ADI it is then.

IIC0: i2c@ef600700 {
	compatible = "ibm,iic-440ep", "ibm,iic-440gp", "ibm,iic";
	reg = <ef600700 14>;
	interrupt-parent = <&UIC0>;
	interrupts = <2 4>;
	index = <0>;
	#address-cells = <1>;
	#size-cells = <0>;

	ad7414@4a {
		compatible = "adi,ad7414";
		reg = <4a>;
		interrupts = <19 8>;
		interrupt-parent = <&UIC0>;
	};
};


Cheers,
  Sean
