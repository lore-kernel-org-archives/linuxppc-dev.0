Return-Path: <Joakim.Tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D1FFC67A67
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Mar 2005 07:43:58 +1100 (EST)
Received: from Jocke ([84.217.0.212]) (authenticated bits=0)
	by dmz.lumentis.net (8.12.8/8.12.8) with ESMTP id j2IKhrNX020735
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Fri, 18 Mar 2005 21:43:54 +0100
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Linuxppc-Embedded" <linuxppc-embedded@ozlabs.org>
Date: Fri, 18 Mar 2005 21:43:52 +0100
Message-ID: <BCEFJBPJCGFCNMMMIDBHKECDCLAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: PCC ABI question
Reply-To: Joakim.Tjernlund@lumentis.se
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Folks

It seems to me that linux doesn't follow the ABI for PowerPC.
According to http://refspecs.freestandards.org/elf/elfspec_ppc.pdf,
Figure 3-31(Initial Process Stack) should the stack ptr point to a NULL word, instead
linux's stack ptr points to argc and there is no NULL word, correct?

The initial register map, on p. 3-28, register r7 should point to a
"termination function" or hold zero. Does linux do this?
If so, where does it get the "termination function" from?
If not, can one assume that r7 is NULL at all times?

Are there other deviations from the above spec in linux?

 Jocke 
