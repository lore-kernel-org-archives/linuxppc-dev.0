Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18586.21980.285793.310196@cargo.ozlabs.ibm.com>
Date: Thu, 7 Aug 2008 11:54:36 +1000
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH] Link the bootwrapper as a position-independent
	executable
In-Reply-To: <6AD17EA2-2053-4196-A78D-D4B505095E00@kernel.crashing.org>
References: <18585.14669.954874.540716@drongo.ozlabs.ibm.com>
	<A1BAD7C8-8459-4D6E-80BA-639D305611DD@kernel.crashing.org>
	<18586.13766.755344.181525@cargo.ozlabs.ibm.com>
	<6AD17EA2-2053-4196-A78D-D4B505095E00@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> ... that is exactly what I meant: the code skips relocation only if
> both are missing.

Doh!  You're right, thanks.  Serves me right for being so clever. :)

Paul.
