Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17545.15326.767523.342562@cargo.ozlabs.ibm.com>
Date: Fri, 9 Jun 2006 19:14:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [RFC/PATCH] powersave_nap cleanup
In-Reply-To: <20060526140227.GE8934@localdomain>
References: <20060526140227.GE8934@localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch writes:

> Rename machdep_calls.power_save to machdep_calls.powersave_nap to make
> more apparent the connection with the powersave_nap sysctl.

Hmmm, it's possibly a bit confusing to have a variable and a function
with the same name...

Paul.
