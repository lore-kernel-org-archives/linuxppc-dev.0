Return-Path: <dan@embeddededge.com>
In-Reply-To: <20050915205709.GA31156@iram.es>
References: <1126644202.11056.59.camel@cashmere.sps.mot.com>
	<200509140435.21916.arnd@arndb.de>
	<1126705588.14036.10.camel@cashmere.sps.mot.com>
	<17193.22140.962651.122114@cargo.ozlabs.ibm.com>
	<20050915205709.GA31156@iram.es>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c61953eb8b052b195971ae7dd9729e26@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 15 Sep 2005 17:21:57 -0400
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: PATCH powerpc: Merge asm-ppc*/sections.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 15, 2005, at 4:57 PM, Gabriel Paubert wrote:

> So yes, I object strongly object if I don't have a way
> of removing useless PMAC code.

Or, any other code that isn't appropriate.  People have
always laughed at me for trying to save bytes here and
there, but I have to say there are many, many more PowerPCs
running Linux in 32M of memory than 2G of memory.

Using the smallest amount of memory to solve the
problem is still the norm, and when you are competing
against other architectures that can run in less memory,
you can't win.  Of course, as Gabriel said, I also see
legacy systems that want to change from another OS
to Linux, but they have 16M soldered on the board (which
was _way_ more than necessary to run that other OS),
and that isn't going to change.

Please, we have to be sensitive to configuring systems
to minimize the resource requirements for Linux.

Thanks.

	-- Dan
