Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5977F1007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  3 Jul 2010 02:22:32 +1000 (EST)
In-Reply-To: <1277980982-12433-1-git-send-email-agraf@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <82C19122-91B6-4F91-9EF0-BEA2759A349D@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 00/27] KVM PPC PV framework
Date: Fri, 2 Jul 2010 18:22:46 +0200
To: Alexander Graf <agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> [without]
>
> debian-powerpc:~# time for i in {1..1000}; do /bin/echo hello > / 
> dev/null; done
>
> real    0m14.659s
> user    0m8.967s
> sys     0m5.688s
>
> [with]
>
> debian-powerpc:~# time for i in {1..1000}; do /bin/echo hello > / 
> dev/null; done
>
> real    0m7.557s
> user    0m4.121s
> sys     0m3.426s
>
>
> So this is a significant performance improvement! I'm quite happy  
> how fast this
> whole thing becomes :)

Yeah :-)  Do you have timings for the native system as well?


Segher
