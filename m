Return-Path: <ssh@sgi.com>
Received: from omx1.americas.sgi.com (omx1-ext.sgi.com [192.48.179.11])
	by ozlabs.org (Postfix) with ESMTP id 1E6FC67B6B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Sep 2006 08:04:36 +1000 (EST)
Received: from imr2.americas.sgi.com (imr2.americas.sgi.com [198.149.16.18])
	by omx1.americas.sgi.com (8.12.10/8.12.9/linux-outbound_gateway-1.1)
	with ESMTP id k8JLp8nx027320
	for <linuxppc-embedded@ozlabs.org>; Tue, 19 Sep 2006 16:51:08 -0500
Received: from moose.americas.sgi.com (moose.americas.sgi.com [137.38.224.25])
	by imr2.americas.sgi.com (8.12.9/8.12.10/SGI_generic_relay-1.2) with
	ESMTP id k8JLmXDu54738448 for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Sep 2006 14:48:33 -0700 (PDT)
Received: from [137.38.88.32] (lnx-ssh.americas.sgi.com [137.38.88.32]) by
	moose.americas.sgi.com (8.12.9/ASC-news-1.4) with ESMTP id
	k8JLp7BO708225 for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Sep 2006 16:51:08 -0500 (CDT)
Message-ID: <4510664B.2020304@sgi.com>
Date: Tue, 19 Sep 2006 16:51:07 -0500
From: Steven Hein <ssh@sgi.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: JTAG debugger for MPC82xx/MPC83xx
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

My group is starting a new project includes a custom board
with an MPC8258E processor on it.   I'm in the process
of evaluating the state of the Linux kernel, toolchains,
etc. for the MPC8258E/MPC8360E, as well as selecting a
JTAG debugger for our project.

I've been researching the available JTAG debuggers that
support the MPC82xx/MPC83xx family, and I've found these
choices so far:

* Abatron BDI-2000
* Green Hills Probe
* Freescale's PowerTAP PRO for PowerPC
* Lauterbach TRACE32-ICD
* WindRiver ICE
* Embedded Toolsmiths Guardian-SE (BUT...this is no longer
  being sold, according to an email response I received
  from Embedded Toolsmiths)

We will definitely want one with a network connection,
and will will run the debugger software from a Linux host.
Ideally, we would also like one that provides a library
to allow us to write apps to function the debugger.

Can anyone comment on what JTAG debugger they are using,
and how have your experiences been?   Are there any other
good options besides the ones mentioned above.
I'd appreciate any input.

Thanks!
Steve

-- 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Steve Hein (ssh@sgi.com)              Engineering Diagnostics/Software
Silicon Graphics, Inc.                          
1168 Industrial Blvd.                 Phone: (715) 726-8410
Chippewa Falls, WI 54729              Fax:   (715) 726-6715
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
