Date: Sun, 4 Jan 2004 15:05:45 +0100
From: Samuel Rydh <samuel@ibrium.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] radeonfb fix
Message-ID: <20040104140545.GA11435@ibrium.se>
References: <20040103183242.GB1309@ibrium.se> <1073170830.10542.41.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1073170830.10542.41.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jan 04, 2004 at 10:00:30AM +1100, Benjamin Herrenschmidt wrote:
> On Sun, 2004-01-04 at 05:32, Samuel Rydh wrote:
> > Hi,
> >
> > The following patch is necessary to get the 2.6 radeonfb driver to detect
> > the flatpanel display. I believe the 2.4 code does exactly the same thing.
>
> Could you verify that the "new" radeonfb driver in my tree works
> fine for you ? I rewrote significant parts of this driver, I expect
> to have it merged upstream soon now.
>

It works indeed.

/Samuel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
