Subject: Re: [PATCH] radeonfb fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Samuel Rydh <samuel@ibrium.se>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040103183242.GB1309@ibrium.se>
References: <20040103183242.GB1309@ibrium.se>
Content-Type: text/plain
Message-Id: <1073170830.10542.41.camel@gaston>
Mime-Version: 1.0
Date: Sun, 04 Jan 2004 10:00:30 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2004-01-04 at 05:32, Samuel Rydh wrote:
> Hi,
>
> The following patch is necessary to get the 2.6 radeonfb driver to detect
> the flatpanel display. I believe the 2.4 code does exactly the same thing.

Could you verify that the "new" radeonfb driver in my tree works
fine for you ? I rewrote significant parts of this driver, I expect
to have it merged upstream soon now.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
