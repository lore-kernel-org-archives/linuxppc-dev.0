Message-ID: <399EB77C.C6734A97@wanadoo.fr>
Date: Sat, 19 Aug 2000 18:36:12 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Andreas Tobler <toa@pop.agri.ch>
CC: Linuxppc-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: rpm-Q
References: <399EB420.AD15500@pop.agri.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Andreas Tobler wrote:
>
> Hi,
> sorry this seems to be a general linux Q, dev-part I think, has anyone a
> solution for this:
> rpm -ihv glibc-2.1.91-18.src.rpm
> only packages with major numbers <= 3 are supported by this version of RPM
> error: glibc-2.1.91-18.src.rpm cannot be installed
>
> I want to build rpm's by myself, but I get the same msg with rpm-4.x, is this a
> classical chicken & egg problem?
>
> BTW: rpm -q rpm rpm-3.0.4-6x

Get rpm-3.0.5, for example from Franz Sirl's directory at
devel.linuxppc.org. It reads rpm-4 packages.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
