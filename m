In-Reply-To: <v04210105b404ed46f043@[192.168.0.1]>
Date: Wed, 15 Sep 1999 11:39:05 +0200
To: Ethan Benson <erbenson@alaska.net>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: New booter
Message-Id: <19990915113905.031280@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Sep 14, 1999, Ethan Benson <erbenson@alaska.net> wrote:

>yes it does this on all machines, and frankly I think its a 
>disgusting kludge, that would be OK as a absolute LAST RESORT *after* 
>all attempts to get a proper booter working have failed.
>
>linux in my view is about doing things better, and doing them *right* 
>Linus himself is fairly picky about doing things right instead of 
>doing a kludge that `works'
>
>Apple's attitude seems to be `why do it right when a kludge will do?' 
>I do not want to see linux choose the same philosophy.

>From Apple perspective, it's not a kludge since the final MacOS X will
boot from HFS+ partitions, so it seems logical to have the bootinfo on an
HFS volume.

>sorry to be blunt but just because apple has chosen to kludge their 
>bootloader does NOT mean that is what we should do.
>


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
