Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f228.google.com (mail-gx0-f228.google.com
	[209.85.217.228]) by ozlabs.org (Postfix) with ESMTP id 4BFB7B7CED
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Mar 2010 04:34:25 +1100 (EST)
Received: by gxk28 with SMTP id 28so5181229gxk.2
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Mar 2010 09:34:23 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4B934CCA.8030608@freemail.hu>
References: <4B934CCA.8030608@freemail.hu>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 8 Mar 2010 10:34:02 -0700
Message-ID: <fa686aa41003080934q5d5bebabl7d582d1264da4dcd@mail.gmail.com>
Subject: Re: cross-compiling Linux for PowerPC e200 core?
To: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/3/6 N=E9meth M=E1rton <nm127@freemail.hu>:
> Hi,
>
> I'm trying to cross-compile Linux 2.6.33 for Freescale MPC5554 [1][2]. Th=
is
> microcontroller is based on the e200z6 core. I could build the cross-deve=
lopment
> tools, but I could miss something because I get an error message when bui=
lding
> Linux for PowerPC e200 core. Here are the steps I used:

I doubt you'll have much luck with the mpc5554.  Linux doesn't include
any support for the MPC5554, and I don't think anybody is working on
it.  Any of the mpc5554 systems I've see don't have enough ram to run
Linux well.

g.
