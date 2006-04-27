Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <17489.18630.75412.66803@cargo.ozlabs.ibm.com>
Date: Fri, 28 Apr 2006 08:42:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH 13/16] ehca: firmware InfiniBand interface
In-Reply-To: <20060427123701.GG32127@wohnheim.fh-wedel.de>
References: <4450A1C0.3080209@de.ibm.com>
	<20060427123701.GG32127@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

J=F6rn Engel writes:

> 25 parameters=3F  If you tell me which drugs were involved in this co=
de,
> I know what to stay away from.

You really need to ask the firmware architects that, since this is
basically a single firmware call.

Mind you, since a lot of the parameters are used to return individual
bytes or half-words, which are then put into structures, it might be
better to pass the pointers to the structures and let the wrapper put
the values straight into the structures.

Paul.
