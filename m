Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <1147041095.4777.170.camel@localhost.localdomain>
References: <445BE72D.3050205@am.sony.com>
	<1147041095.4777.170.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BE9739CD-B66A-43A4-B5E9-2DE49CEDE5B7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch] powerpc: remove do-nothing cpu setup routines
Date: Mon, 8 May 2006 02:12:21 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Removes the processor specific do-nothing routines  
>> __setup_cpu_power3 and
>> __setup_cpu_power4 with the generic routine __setup_cpu_null.
>
> Why not just change the caller to test for NULL ?

Yes, please do (as Paul suggested already).


Segher
