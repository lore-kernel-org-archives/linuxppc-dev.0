Return-Path: <eberhard.stoll@berghof.com>
Received: from mail117.messagelabs.com (mail117.messagelabs.com
	[195.245.231.211]) by ozlabs.org (Postfix) with SMTP id E7BE167B14
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Mar 2006 20:00:55 +1100 (EST)
Message-ID: <4427A9C1.3060000@berghof.com>
Date: Mon, 27 Mar 2006 11:00:49 +0200
From: Eberhard Stoll <eberhard.stoll@berghof.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Interpreting /proc/meminfo. How much free memory do I have?
References: <20060327064907.23992.qmail@mx1.aruba.it>
	<200603270953.11079.roger.larsson@norran.net>
In-Reply-To: <200603270953.11079.roger.larsson@norran.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Roger Larsson schrieb:

>On måndag 27 mars 2006 08.49, antonio.dibacco wrote:
>  
>
>>Hi,
>>
>>I'm a little bit puzzled with the fields in /proc/meminfo. Which fields
>>have I to sum up to get the amount of free memory?
>>    
>>
>
>>From a 2.6 /proc/meminfo
>
>MemTotal:       515532 kB
>MemFree:          6012 kB
>Buffers:         79964 kB
>Cached:          83264 kB
>SwapCached:      82840 kB
>Active:         294024 kB
>Inactive:       130304 kB
>- - -
>
>Completely free is only MemFree. But those pages are only needed for
>interrupt handlers (close enough).
>
>Cached pages are also free but since they contain data that maybe will
>be needed again (unmodified data that already is on disk) they are not
>returned to MemFree state.
>
>Inactive pages has not been in use for awhile and can be written out
>if needed (some are probably unmodified and quick to get)
>  
>
Active + Inactive + MemFree is not equal MemTotal. Where can i find the
offset?

Thanks,
Eberhard
