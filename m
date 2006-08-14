Return-Path: <anton@ozlabs.org>
Date: Tue, 15 Aug 2006 00:38:42 +1000
From: Anton Blanchard <anton@samba.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH 1/6] ehea: interface to network stack
Message-ID: <20060814143842.GM479@krispykreme>
References: <44D99EFC.3000105@de.ibm.com> <20060811205624.GE479@krispykreme>
	<20060814112656.GC10164@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060814112656.GC10164@wohnheim.fh-wedel.de>
Cc: Thomas Klein <tklein@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Is a conditional cheaper than a divide?  In case of a misprediction I
> would assume it to be significantly slower and I don't know the ratio
> of mispredictions for this branch.

A quick scan of the web shows 40 cycles for athlon64 idiv, and its
similarly slow on many other cpus. Even assuming you mispredict every
branch its going to be a win.

Anton
