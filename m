Return-Path: <lk99336@pobox.sk>
Received: from rohlik.mail-atlas.net (rohlik.mail-atlas.net [212.47.13.83])
	by ozlabs.org (Postfix) with ESMTP id 4CBD167A5D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 22:03:35 +1000 (EST)
Received: from rohlik ([127.0.0.1]) by rohlik.mail-atlas.net
	for linuxppc-embedded@ozlabs.org; Tue, 23 May 2006 14:02:49 +0200
From: "=?windows-1250?B?TGFkaXNsYXYgS2xlbm92aeg=?=" <lk99336@pobox.sk>
To: linuxppc-embedded@ozlabs.org
Message-ID: <3348e5d9925e49e2badcd00d615156b4@pobox.sk>
Date: Tue, 23 May 2006 14:02:49 +0200
Subject: UART DRIVER on 2.6.15
MIME-Version: 1.0
Content-type: text/plain; charset=windows-1250
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
just a simple question, is uart driver for kernel 2=2E6=2E15 complete=2E=
=20
There are some parts like:
 void scc1_lineif(struct uart_cpm_port *pinfo)
{
        /* XXX SCC1: insert port configuration here */
        pinfo->brg =3D 1;
}
=2E=2E=2E=2E
that seems to incomplete=2E Am I able to do something with SCC1 with th=
e current cpm_uart code?

Maybe stupid question, is there any way (is it possible) to import old =
uart driver from kernel 2=2E4=2Ex to kernel 2=2E6=2Ex

Regards,
Ladislav Klenovic
