Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.231])
	by ozlabs.org (Postfix) with ESMTP id D0FD5DDE0C
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Mar 2008 07:46:26 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so4192645wxd.15
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Feb 2008 12:46:25 -0800 (PST)
Message-ID: <fa686aa40802291246v676042davca91e21a08846846@mail.gmail.com>
Date: Fri, 29 Feb 2008 13:46:24 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Phil Hochstetler" <Phil.Hochstetler@serveron.com>
Subject: Re: ML403 Linux port questions
In-Reply-To: <ADA5878BA63680469C75C14CEEE2FE28012F482B@mail.serveron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <ADA5878BA63680469C75C14CEEE2FE28012F482B@mail.serveron.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Feb 29, 2008 at 10:24 AM, Phil Hochstetler
<Phil.Hochstetler@serveron.com> wrote:
> I guess what I am looking for is advise on the lowest risk, easiest to set
> up environment to setup that will just work.  Also advise on which kernel to
> use.   I don't need a detailed tutorial but a high level direct that is
> known to work.  I am thinking of using either the secret lab tree or the
> Xilinx tree as recommended in Grants wiki page.  Should I just forget using
> XP and install a Linux (x86 processor so I must use cross tools)?   If so,
> what is the recommend distro and what version?

Yes, absolutely.  Going down the cygwin path is doable, but it is a
path of pain.  I strongly recommend using a Linux host.  (I personally
use Ubuntu, but you should have good success with any disto.  Use what
you're most comfortable with).

The simplest approach to get running with a Linux box is to install
either VirtualBox or VMware and create yourself a Linux virtual
machine.  That will get you up and running without having to obtain
new hardware or risk breaking your XP setup.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
