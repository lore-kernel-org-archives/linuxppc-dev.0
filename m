Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C6D1A26.1040209@capflow.com>
Date: Fri, 15 Feb 2002 15:24:38 +0100
From: Laurent Pinchart <laurent.pinchart@capflow.com>
MIME-Version: 1.0
To: wd@denx.de
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SCC or SMC for console ?
References: <20020214183203.C4651109E2@denx.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Reply-To: laurent.pinchart@capflow.com
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>
>Should be no problem. The kernel on our FTP server was tested with  6
>serial  ports  on  a  MPC860, with HW flow controll on all SCC's.
>
Reading arch/ppc/8xx_io/uart.c, I found out that all the flow control
related code was surrounded by false #if #endif. It seems that there is
no flow control at all on either the SMC or SCC serial ports in UART
mode. Is there a patch somewhere to implement flow control, or is it
still missing ? I was wondering what to do with CD/DTR/DSR (as Linux
only support RTS/CTS flow control for now), and had hoped to find an
answer in the source code...

Laurent Pinchart


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
