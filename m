Message-Id: <20000820015959.Postino-001055@smtp01.highway.ne.jp>
Date: Sun, 20 Aug 2000 01:59:59 +0900
To: Andreas Tobler <toa@pop.agri.ch>
CC: Linuxppc-Dev <linuxppc-dev@lists.linuxppc.org>
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: rpm-Q
In-Reply-To: <399EB420.AD15500@pop.agri.ch>
References: <399EB420.AD15500@pop.agri.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Andreas Tobler <toa@pop.agri.ch>
To: Linuxppc-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: rpm-Q
Date: Sat, 19 Aug 2000 18:21:52 +0200
Cc:

>
> Hi,
> sorry this seems to be a general linux Q, dev-part I think, has anyone a
> solution for this:
> rpm -ihv glibc-2.1.91-18.src.rpm
> only packages with major numbers <= 3 are supported by this version of RPM
> error: glibc-2.1.91-18.src.rpm cannot be installed
>
> I want to build rpm's by myself, but I get the same msg with rpm-4.x, is
this a
> classical chicken & egg problem?
>
> BTW: rpm -q rpm rpm-3.0.4-6x
>
> Thanks,
>
> Andreas
>

Recent rmp is not stable, i am using rpm.org's cvs rpm.

Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
