Date: Thu, 2 Nov 2000 23:56:06 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
Message-ID: <20001102235606.B30436@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
References: <14839.53124.753011.489351@argo.linuxcare.com.au> <39F96E14.C06AB6FB@mpifr-bonn.mpg.de> <20001027163923.A13804@suse.de> <3A015F72.2576BB01@mpifr-bonn.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <3A015F72.2576BB01@mpifr-bonn.mpg.de>; from ad@mpifr-bonn.mpg.de on Thu, Nov 02, 2000 at 01:34:58PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 02, Albrecht Dreß wrote:

> Olaf Hering wrote:
> > Try current linux-pmac-benh.
>
> O.K., I rsynced linux-pmac-benh from penguinppc.org (which is version
> 2.2.18pre17-ben1), built it, and now I get a kernel panic upon wakeup. My pmud
> version is still 0.7.1.
>
> I attach the kernel .config and the relevant part from /var/log/messages, and as
> always, any help is _really_ welcome!

Hmm, I can provide diffs between 2.2.18pre15-ben1 and the current tree,
if someone needs that.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
