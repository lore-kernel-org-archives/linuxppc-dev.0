Return-Path: <jourdan@enib.fr>
Received: from alto.enib.fr (alto.enib.fr [195.221.233.5])
	by ozlabs.org (Postfix) with ESMTP id 9AA6E67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 May 2006 22:06:23 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by alto.enib.fr (Postfix) with ESMTP id 50402EF1EE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 May 2006 14:00:15 +0200 (CEST)
Received: from alto.enib.fr ([127.0.0.1])
	by localhost (alto.enib.fr [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP
	id 20997-03 for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 May 2006 14:00:15 +0200 (CEST)
Received: from webmail.enib.fr (localhost.localdomain [127.0.0.1])
	by alto.enib.fr (Postfix) with ESMTP id 32C2FEF1ED
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 May 2006 14:00:15 +0200 (CEST)
Message-ID: <2096.194.3.133.184.1148990415.squirrel@webmail.enib.fr>
In-Reply-To: <2095.194.3.133.184.1148990341.squirrel@webmail.enib.fr>
References: Your message of "Mon, 29 May 2006 09:34:00 +0200."               
	<1402.194.3.133.184.1148888040.squirrel@webmail.enib.fr>     
	<20060529091257.686CB3525D9@atlas.denx.de><1758.194.3.133.184.1148897976.squirrel@webmail.enib.fr>
	<1664.194.3.133.184.1148981963.squirrel@webmail.enib.fr>   
	<004b01c683db$96711e30$6401a8c0@CHUCK2>
	<2095.194.3.133.184.1148990341.squirrel@webmail.enib.fr>
Date: Tue, 30 May 2006 14:00:15 +0200 (CEST)
Subject: Re: Can't get CoralP drivers to work
From: jourdan@enib.fr
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Does the 8270 swap bytes on the PCI bus?  The CoralP drivers are written
> for
> the 5200, which assumes any PCI card to be little-endian, and thus swaps
> bytes.  That is, if you write a 32-bit word, say 0x01020304, the 5200
> PCI
> will actually write 0x04030201.  So if 8270 does *not* swap bytes like
> that
> it would be a problem.
>

I checked this and the byte swapping is OK.
