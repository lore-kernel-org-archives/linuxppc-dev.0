From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [BUG] in glibc-2.1.1-6b: gethostbyname broken
Date: Mon, 10 May 1999 00:20:33 +0200
Content-Type: text/plain
Cc: Tom Rini <tmrini@ntplx.net>
References: <37342C2B.E435F291@wanadoo.fr>
MIME-Version: 1.0
Message-Id: <99051000253500.04861@ns1102.munich.netsurf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am Sat, 08 May 1999 schrieb Martin Costabel:
>>
>Under glibc-2.1.1-6b, I cannot do an NFS-mount using the numeric IP
>address of the server. Without even consulting the net, mount says:
>  mount: can't get address for xx.xx.xx.xx
>
>Under glibc-2.1.1-5b, it works correctly.
>
>I tracked this down to gethostbyname, which doesn't work correctly when
>fed a numeric IP address.
>
>If I run the the attached program as
> tstgethbn 193.252.19.78 
>I get a correct result when glibc-2.1.1-5b.ppc.rpm is installed, and an
>error when glibc-2.1.1-6b.ppc.rpm is installed. Both rpms are from
>mirror.linuxppc.org.
>
>Could someone who knows what changed between 5b and 6b please look into
>this?

Fixed in glibc-2.1.1-6c. This was a general bug in glibc-2.1.1pre2, I've
updated to a current glibc CVS snapshot which fixes it.

Thanks for your report.

Franz.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
