Return-Path: <blofeldus@yahoo.com>
Received: from web53502.mail.yahoo.com (web53502.mail.yahoo.com
	[206.190.37.63]) by ozlabs.org (Postfix) with SMTP id AFE6F2BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Nov 2004 05:26:14 +1100 (EST)
Message-ID: <20041116182609.68313.qmail@web53502.mail.yahoo.com>
Date: Tue, 16 Nov 2004 10:26:09 -0800 (PST)
From: roger blofeld <blofeldus@yahoo.com>
To: Dale Farnsworth <dale@farnsworth.org>,
	linuxppc-embedded@ozlabs.org, Sylvain Munaut <tnt@246tNt.com>
In-Reply-To: <20041115173402.GA22661@xyzzy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: Lite5200 FEC Driver on linux 2.6 broken? (again)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Retransmissions from the lite5200 work OK now, but the occasional ACK
packet is sent from the lite5200 with a bad checksum causing
retransmissions. Perhaps another patch would fix this problem too?
-roger


		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - Get yours free! 
http://my.yahoo.com 
 
