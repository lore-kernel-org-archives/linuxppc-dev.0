In-Reply-To: <16334.33020.624995.521330@cargo.ozlabs.ibm.com>
References: <16334.33020.624995.521330@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v606)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <18650AD8-26B7-11D8-B321-000393DBC2E8@motorola.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
From: Kumar Gala <kumar.gala@motorola.com>
Subject: Re: the door is closing for 2.4
Date: Thu, 4 Dec 2003 18:08:03 -0600
To: Paul Mackerras <paulus@samba.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


A few questions/requests:

1. Can we create a file maybe in platforms for 2.4 that lists the
maintainers of all the boards as it stands for official 2.4
2. Do you plan on closing down 2.4 based development after marcelo does?

Thanks

- kumar

On Dec 3, 2003, at 6:34 PM, Paul Mackerras wrote:

>
> Guys,
>
> Marcelo has announced that as of 2.4.25, the official 2.4 tree is
> going into maintenance-only mode.  There is still a lot of stuff in
> the linuxppc-2.4 and linuxppc_2_4_devel trees which hasn't gone into
> the official 2.4 tree.  Most of that is board ports for various
> embedded boards, and for many of those boards, it's not clear whether
> anyone cares whether they are supported by the official 2.4 or not.
>
> So if you have a board that you want to see supported by the official
> 2.4 tree, and it isn't already, let me know.  I will need someone to
> commit to maintaining the port on an ongoing basis before I send it to
> Marcelo, though.
>
> We also need people to start moving their embedded board ports to
> 2.6, along with all the related device drivers, etc.  We are already
> past the point where new development should all be done in 2.5/2.6.
>
> Paul.
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
