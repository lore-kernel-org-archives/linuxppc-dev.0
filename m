Return-Path: <anton@ozlabs.org>
Date: Thu, 21 Dec 2006 11:36:59 +1100
From: Anton Blanchard <anton@samba.org>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: Mutex debug lock failure [was Re: Bad gcc-4.1.0 leads to Power4
	crashes... and power5 too, actually
Message-ID: <20061221003658.GB3048@krispykreme>
References: <20061220004653.GL5506@austin.ibm.com>
	<1166579210.4963.15.camel@otta>
	<20061220211931.GB16860@austin.ibm.com>
	<1166650134.6673.9.camel@localhost.localdomain>
	<20061220230342.GC16860@austin.ibm.com>
	<1166656195.6673.23.camel@localhost.localdomain>
	<20061220234647.GD16860@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061220234647.GD16860@austin.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, Dec 20, 2006 at 05:46:47PM -0600, Linas Vepstas wrote:

> System assert at:  file: rtas_io_config.c  -- line: 195
> rio_hub_num: 10
> drawer_num: 6
> phb_num: 3
> buid: 7

Looks like a firmware assert. Did you pass in something dodgy to a
config read/write op? Maybe a bad buid?

Anton
