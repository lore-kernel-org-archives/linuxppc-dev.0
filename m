Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 1E49FDDF05
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 09:19:28 +1100 (EST)
Date: Thu, 20 Mar 2008 18:19:26 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: DTS question
Message-ID: <20080320181926.2ff7e297@lappy.seanm.ca>
In-Reply-To: <20080320173302.7075a1d9@lappy.seanm.ca>
References: <20080320173302.7075a1d9@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok, here is what I did....

IIC0: i2c@ef600700 {
	compatible = "ibm,iic-440ep", "ibm,iic-440gp", "ibm,iic"; 
	reg = <ef600700 14>; 
	interrupt-parent = <&UIC0>;
	interrupts = <2 4>;
	index = <0>;

	ad7414 {
		compatible = "ad7414";
		interrupts = <19 8>;
		interrupt-parent = <&UIC0>;
	};
};

Comments?

Cheers,
   Sean
