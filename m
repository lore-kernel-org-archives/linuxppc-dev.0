Subject: Re: linux ram size
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: somshekar chandrashekar kadam <som_kadam1@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20030919105119.26534.qmail@webmail27.rediffmail.com>
References: <20030919105119.26534.qmail@webmail27.rediffmail.com>
Content-Type: text/plain
Message-Id: <1063969891.22594.12.camel@linpc003.aimsys.nl>
Mime-Version: 1.0
Date: 19 Sep 2003 13:11:31 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I think you just need to pass in your bd_t structure
the proper amount of ram to kernel, so it looks ppc boot
pass someting else (16MB) to the kernel.

Jaap-Jan

On Fri, 2003-09-19 at 12:51, somshekar chandrashekar kadam wrote:
> hi ,
>
>     Ineed to know can i run my linux with 8mb of ram , what
> changes i need to do with my mpc860 linuxppc code as i see he is
> mapping 8mb and again 8mb , totally 16mb he is using , soi am not
> getting anything proper , it hangs after uncompressing the kernel
> ,i use ppcboot .
> my ram size is 8mb
> pls mail to this id
>
> Thanksin advance
> Somshekar
> ___________________________________________________
> Art meets Anesthesia; Shefali Weds Dr. Raman.
> Rediff Matchmaker strikes another interesting match !!
> Visit http://matchmaker.rediff.com?1
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
