Date: Wed, 2 Aug 2000 09:37:11 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Rolf Liu <rolfl@sc23.sc.mcel.mot.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: question of 'SIZEOF_HEADERS' !!!!!!!!!!!!!!!
In-Reply-To: <015401bffbae$1aa27940$bf0102c8@sc.mcel.mot.com>
Message-ID: <Pine.HPX.4.10.10008020935410.9070-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 1 Aug 2000, Rolf Liu wrote:

>
> Hi, all
> I am linking the linux ppc kernel .
> I found a symblo named 'SIZEOF_HEADERS' in the link script file
> 'vmlinux.lds'.
> I wonder where the symbol come from.

info ld

(Hint: builtin functions section)

	Gabriel.
kkk


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
