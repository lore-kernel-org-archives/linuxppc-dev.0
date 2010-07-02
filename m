Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id DC91A1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  3 Jul 2010 02:59:15 +1000 (EST)
Subject: Re: [PATCH 00/27] KVM PPC PV framework
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <82C19122-91B6-4F91-9EF0-BEA2759A349D@kernel.crashing.org>
Date: Fri, 2 Jul 2010 18:59:11 +0200
Message-Id: <5D407F89-B6B4-4890-9E7C-596354CB5BE3@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
	<82C19122-91B6-4F91-9EF0-BEA2759A349D@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
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


On 02.07.2010, at 18:22, Segher Boessenkool wrote:

>> [without]
>>=20
>> debian-powerpc:~# time for i in {1..1000}; do /bin/echo hello > =
/dev/null; done
>>=20
>> real    0m14.659s
>> user    0m8.967s
>> sys     0m5.688s
>>=20
>> [with]
>>=20
>> debian-powerpc:~# time for i in {1..1000}; do /bin/echo hello > =
/dev/null; done
>>=20
>> real    0m7.557s
>> user    0m4.121s
>> sys     0m3.426s
>>=20
>>=20
>> So this is a significant performance improvement! I'm quite happy how =
fast this
>> whole thing becomes :)
>=20
> Yeah :-)  Do you have timings for the native system as well?

Sure, same machine with openSUSE 11.1 instead of Debian that I use as =
guest OS usually:

agraf@lychee:~> time for i in {1..1000}; do /bin/echo hello > /dev/null; =
done

real	0m2.088s
user	0m0.704s
sys	0m1.460s


Alex
