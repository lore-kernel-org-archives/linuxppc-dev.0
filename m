Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17250.48622.69899.322254@cargo.ozlabs.ibm.com>
Date: Sat, 29 Oct 2005 10:10:22 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Christopher Friesen" <cfriesen@nortel.com>
In-Reply-To: <43624B30.20600@nortel.com>
References: <17250.8725.358204.62510@cargo.ozlabs.ibm.com>
	<43624B30.20600@nortel.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: Patches for 2.6.15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christopher Friesen writes:

> Under the unified architecture, what is the machine type in the "uname" 
> outout?

"ppc" on 32-bit machines, "ppc64" on 64-bit machines, same as before.

The intention is that the merge doesn't change the user/kernel ABI in
any way. :)

Paul.
