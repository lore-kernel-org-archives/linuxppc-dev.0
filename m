Date: Mon, 21 Jul 2003 18:16:14 -0500
Subject: Re: kernel performance monitoring
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: <linuxppc-dev@lists.linuxppc.org>
To: Dan Burcaw <dburcaw@terrasoftsolutions.com>
From: Kumar Gala <kumar.gala@motorola.com>
In-Reply-To: <1058817077.1621.30.camel@skyfox.terraplex.com>
Message-Id: <52DC45E1-BBD1-11D7-ABAA-000393DBC2E8@motorola.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan,

Depending on what processor your running on you can setup the
performance monitor counters to count such
events and gate it by the MSR[PR] bit setting.

- kumar

On Monday, July 21, 2003, at 02:51 PM, Dan Burcaw wrote:

>
> Hi,
>
> Does anyone know of a method to measure cache hit/misses
> and other performance indicators from the kernel?  If so,
> I'd appreciate a link, etc. to the relevant information.
>
> Thanks!
>
> Dan
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
