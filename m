In-Reply-To: <v03110701b4eda44b28b7@[129.100.29.243]>
Date: Fri, 10 Mar 2000 10:43:51 +0100
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: IDE problems with 2.3.49?- same with 2.2.15pre3
Message-Id: <20000310104351.001539@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 9, 2000, Kevin B. Hendricks <khendricks@ivey.uwo.ca> wrote:

>I grabbed the yellowdog yaboot_0.4 (I can not get your yaboot_0.5 to
>uncompress properly) and started up with with the following yaboot.conf

there's a problem with Apache configuration on ppclinux.apple.com (which
is, BTW, the same problem i used to have when downloading Xpmac from your
web server). Apparently, the server tries to uncompress the gz file on
the fly. It appears however that most web browser will only download the
compressed size, and so the downloaded file is incomplete.
I used to work around this (when downloading Xpmac from your site) by
using Netscape under MacOS (apparently, it did download the entire
uncompressed file), and removing manally the ".gz" once downloaded.

If you know the solution (the server setting that need to be changed),
tell me and I'll pass the info along to Kevyn (maintainer of
ppclinux.apple.com).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
