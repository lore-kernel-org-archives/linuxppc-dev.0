From: Benjamin Herrenschmidt <bh40@calva.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: color maps issues
Date: Thu, 3 Aug 2000 15:31:17 +0200
Message-Id: <20000803133117.15086@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.10.10008022223240.833-100000@cassiopeia.home>
References: <Pine.LNX.4.10.10008022223240.833-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>The patch looks OK to me.

When I checked last week, the version in bk 2.4 was already ok. I fixed
it in my 2.2 tree too. Time to merge some of my 2.2 stuffs to bk 2.2...

>> > that Kevin sent me last week. However after finding Kevin's original
>> > message I think he final suggestion in it is right and we should have
>> > a patch placed in aty128fb.c which shrinks the virtual resolution down
>> > to match the physical resolution in xfree when mode switching.
>>
>> I don't think that's possible without destroying the framebuffer contents.
>
>Indeed. Besides, shrinking vxres is not allowed per the frame buffer device
>API rules.
>
>As the 'to do' list in aty128fb.c states, panning still has to be
implemented.
>Anyone with a patch?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
