Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3CB60E13.BA0A4A6@esteem.com>
Date: Thu, 11 Apr 2002 15:28:35 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC8xx fpu support and compiling glib.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello All,


	I was wondering a few things about MPC8xx FPU support. If
I build a kernel with fpu-emulation do I have to pass the CFLAGS
"-msoft-float -D_SOFT_FLOAT" when compiling glibc? Does it save me
any ram if I don't? I know if I don't my performance will drop but
our aplication doesn't use floating point except for ping mabey.


Thanks in advance,

	Conn
--

*****************************************************************
  If you live at home long enough, your parents will move out.
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com

Stock Ticker Symbol				ELST

"clark@esteem.com" Copyright 2000 By Electronic Systems Technology
 This email address may be used to communicate to Conn Clark
 provided it is not being used for advertisement purposes, unless
 prior written consent is given. This email address may not be
 sold under any circumstances. All other rights reserved.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
