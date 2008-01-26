Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 752D4DDE0D
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 16:44:20 +1100 (EST)
Message-ID: <479AC8B3.4010200@pikatech.com>
Date: Sat, 26 Jan 2008 00:44:19 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: i2c-ibm_iic.c fix
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If anybody is following this patch it needs to be updated. It was 
recommended that the device_type be removed from the dts files. But the 
table matches the type, so I changed the table to only match the 
compatibility. I can give people a full blown patch if they want it. But 
basically the table should look like follows:

static const struct of_device_id ibm_iic_match[] =
{
	{ .compatible = "ibm,iic-405ex", },
	{ .compatible = "ibm,iic-405gp", },
	{ .compatible = "ibm,iic-440gp", },
	{ .compatible = "ibm,iic-440gpx", },
	{ .compatible = "ibm,iic-440grx", },
	{}
};



Cheers,
   Sean
