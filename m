Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Keith Clayton <keith@claytons.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: glibc 2.1 -> 2.2 gotchas?
Date: Sat, 25 Aug 2001 11:31:43 -0400
References: <998751333.12597.3.camel@yoda>
In-Reply-To: <998751333.12597.3.camel@yoda>
MIME-Version: 1.0
Message-Id: <01082511314308.15847@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Keith,

If you are using an RPM based distribution, please be careful.  When I tried
to do the upgrade manually awhile back I ran into trouble with many of the
new rpms being usable in RPM 4 format only and not working under RPM 3.

If I were you I would rebuild glibc 2.2.4 from a source rpm (from Franz) and
run make check first just to make sure all is well.  I would then focus on
building RPM 4 and then try to convert your rpm database over from RPM 3 to
RPM 4.o and then continue upgrading pieces.

The other easy way to make this move is to simply upgrade to YDL 2, SuSE 7.1,
Debian, Mandrake, etc. They are all glibc 2.2.X based and come with all of
the other things that need to be upgraded since they are so old (Perl, etc).

Upgrading them from glibc-2.2.1 to glibc 2.2.4 is easily done with rpm a few
syncs and a restart.

Hope this helps,

Kevin

On Saturday 25 August 2001 10:55, Keith Clayton wrote:
> Hi all,
>
> I'm considering moving from glibc 2.1.3 to 2.2.4  Any known problems
> with the move to 2.2, apps that break, etc.
>
> I'm hoping to minimize any surprises
>
>
> Thanks
> Keith
>
>
> --
> <><><><><><><><><><><><>
> Keith Clayton
> keith@claytons.org
>
> "If you don't trust me with your source code,
>             why should I trust you with my computer?"
>
> GPG key: http://home.pacbell.net/clay-ton/keith_public_key.html
>          http://www.keyserver.net
>
> GPG fingerprint: 33FF 1D80 4562 1600 4BAB  5018 BCB7 635C B0CC 99EE
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
