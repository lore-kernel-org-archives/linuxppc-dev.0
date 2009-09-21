Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id D8D39B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Sep 2009 03:03:11 +1000 (EST)
Date: Mon, 21 Sep 2009 18:42:07 +0200
From: Gabriel Paubert <paubert@iram.es>
To: "dibacco@libero.it" <dibacco@libero.it>
Subject: Re: High load average  but low cpu (xenomai can be the explanation?)
Message-ID: <20090921164207.GA26996@iram.es>
References: <17851044.2911671253545985517.JavaMail.root@wmail27>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17851044.2911671253545985517.JavaMail.root@wmail27>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 21, 2009 at 05:13:05PM +0200, dibacco@libero.it wrote:
> Hi,
> 
> I have an MPC880 @133MHz. If I look into the load (with uptime) I get 
> values around 3.0 but my CPU is always under 5 percent (top). How could I 
> explain this? I'm using linux 2.6.19 with xenomai but no xenomai application is 
> running at all. I have a cramfs on a nor flash. What could be the problem? If I 
> kill the process I developed the average load goes down.

What's the process doing when it's not running?

Under top, what is the percentage of wait (x.x%wa)?

	Gabriel
