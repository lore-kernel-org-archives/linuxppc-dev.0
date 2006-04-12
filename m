Return-Path: <glikely@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.189])
	by ozlabs.org (Postfix) with ESMTP id A9AE767C58
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Apr 2006 04:42:10 +1000 (EST)
Received: by nproxy.gmail.com with SMTP id p77so1025153nfc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 11:42:08 -0700 (PDT)
Message-ID: <528646bc0604121142l115a4fa4r1d9e6bc532300fb7@mail.gmail.com>
Date: Wed, 12 Apr 2006 12:42:06 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Vincent Winstead" <vwinstead@yahoo.com>
Subject: Re: Xilinx Virtex-2 PRO FPGA ppc 405 on ML310 board
In-Reply-To: <20060412172641.32987.qmail@web52014.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <528646bc0604111246t5fa92de4n73a43bfb6714b6e@mail.gmail.com>
	<20060412172641.32987.qmail@web52014.mail.yahoo.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/12/06, Vincent Winstead <vwinstead@yahoo.com> wrote:
> Thanks for the info!  Now I installed rsync onto this computer with
> configure, then make, then make install and everything seemed to install
> correctly.  Then i typed in:
>
>  rsync rsync://source.mvista.com/linuxppc-2.4
>
>  but it ended up showing a timed-out error message:
>
>  rsync: failed to connect to source.mvista.com: Connection timed out (110=
)
>  rsync error: error in socket IO (code 10) at clientserver.c(107) [receiv=
er]
>
>  Now, I've had problems in the past in that I can't access any ftp server=
s
> due to the fact that I am behind a firewall that I have no control over (=
on
> the University of Minnesota campus) and I was wondering - do you think th=
is
> might be related to that same problem?

You poor sod.  Yes, this is probably the same problem.  You can access
it via http instead.  (the git trees on kernel.org can be accessed
with rsync, http and git protocols.)

BTW, you need to download and install git also (and cogito for a nicer
front end).

http://git.or.cz/

Then you can do a "cg clone <depot>" to get the tree

g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 399-0195
