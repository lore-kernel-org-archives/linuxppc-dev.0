Date: Fri, 29 Sep 2000 19:55:38 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Michel Dänzer <daenzerm@student.ethz.ch>
cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        R Shapiro <rshapiro@bbn.com>,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
In-Reply-To: <39D45ACA.9E151BCC@student.ethz.ch>
Message-ID: <Pine.LNX.4.21.0009291925410.1084-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 29 Sep 2000, Michel [iso-8859-1] Dänzer wrote:

> However, I think the "fbdev" option should also be available, it might be more
> straightforward for some users than the bus ID. Would it also be possible to
> go the opposite way fbdev -> pcidev and then claim the PCI device?
>

It should be possible to do it, i'll give it a try once i have some free
time. We could get away from the busID requirement in the fbdev driver then
(its very easy to missmatch busID/fbdev and nothing can detect this error)

  Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
