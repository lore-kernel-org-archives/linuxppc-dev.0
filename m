Message-ID: <13b501c41283$7e2ab3c0$3cc8a8c0@epro.dom>
From: "Colin Leroy" <colin@colino.net>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"linuxppc-dev list" <linuxppc-dev@lists.linuxppc.org>
Cc: <debian-powerpc@lists.debian.org>
References: <1080197240.1210.2.camel@gaston> <1080201697.1217.3.camel@gaston>
Subject: Re: PREEMPT on PPC
Date: Thu, 25 Mar 2004 17:09:03 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben!

> + *
> + * 24/03/2004 - BenH: Bump that limitation to 512k and remove the
> + *                    filter for the MacOS drivers as we may now run
> + *                    those in a shell
>   */
> -#define MAX_PROPERTY_LENGTH 4096
> +#define MAX_PROPERTY_LENGTH (512 * 1024)

It doesn't look like related to preempt, but it actually interests me :)
Is it a work in progress ? And most importantly ;), does it enable us to
reboot a radeon 9200 after sleep ?

--
Colin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
