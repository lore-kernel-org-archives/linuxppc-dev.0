Message-ID: <3E96E674.7020703@mvista.com>
Date: Fri, 11 Apr 2003 10:59:48 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Anand Franklin J <franklin@innomedia.soft.net>
Cc: Linux Monta Vista <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Kernel panic: No init found!!!!
References: <3E96E4B6.582DA2F9@innomedia.soft.net>
In-Reply-To: <3E96E4B6.582DA2F9@innomedia.soft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Anand Franklin J wrote:
> hello All,
>     I as using the Redwood 6 IBM PPC board. The Kernel gives the panic
> when it boots (Kernel panic: No init found). can anybody say what is the
> way to get rid off it.

Check the list archives..

Simple answer though, you don't have a valid filesystem.  Init not found may be
read as "init could not be found or properly executed."

--Mark

(BTW from you CC, you list the name of this list as "Linux Monta Vista".. this
list has nothing to do with MontaVista, it's a community list..... and
MontaVista is one word.. <grin>)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
