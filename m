Return-Path: <achim.machura@berghof.com>
Received: from mail123.messagelabs.com (mail123.messagelabs.com [85.158.136.3])
	by ozlabs.org (Postfix) with SMTP id ECDA368387
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Oct 2005 23:21:05 +1000 (EST)
Received: from BATEEE52 (batee-e52.be-int [10.255.241.52])
	by pegasus.berghof.com (8.12.10/8.12.10) with SMTP id j9ADDgMM011747
	for <linuxppc-embedded@ozlabs.org>; Mon, 10 Oct 2005 15:13:42 +0200
From: "Achim Machura" <achim.machura@berghof.com>
To: "'Tomasz Prochownik'" <916@mcd.com.pl>
Date: Mon, 10 Oct 2005 15:13:35 +0200
Message-ID: <000b01c5cd9c$6ca23850$34f1ff0a@beint.local>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
In-Reply-To: <99477CB23E7ACB4EA366A2B6970DA618060F7E@mcdserver.mcd.com.pl>
Cc: "Linuxppc-Embedded \(E-Mail\)" <linuxppc-embedded@ozlabs.org>
Subject: AW: MPC5200,PSC in uart mode, receiving problem
Reply-To: achim.machura@berghof.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Tomasz

> blocks (there is no response in the console).

perhaps we have the same problem a few times ago.
When we connect devices on ttySx which have wrong level on the lines the
uart stay in break mode.

I have made some fixes on the psc-driver. With these fixes the uart works,
but i don't know how efficient.
(clear breakmode and clear buffer)

If you want, i can send the code


best regards
achim
