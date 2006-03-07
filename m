Return-Path: <antonio.dibacco@aruba.it>
Received: from mx1.aruba.it (mxaruba.aruba.it [62.149.128.10])
	by ozlabs.org (Postfix) with SMTP id 1FB7C679EF
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Mar 2006 00:15:10 +1100 (EST)
Message-ID: <20060307131500.3467.qmail@mx1.aruba.it>
From: "antonio.dibacco" <antonio.dibacco@aruba.it>
To: linuxppc-embedded@ozlabs.org
Subject: fs_enet on 2.4 and 8xx_immap
Date: Tue, 07 Mar 2006 13:15:00 GMT
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I think that to make it work I need to update cpm8xx_t inserting the fec2 
filed. Is this true? Could I use the 8xx_immap.h of a 2.6 kernel?

Bye,
Antonio.
