Message-ID: <007701c1bf2f$da283200$1a11efcb@industrialDiv.hanasys.co.kr>
Reply-To: "Sangmoon Kim" <dogoil@etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: "Subhachandra Chandra" <Subhachandra.Chandra@cosinecom.com>,
	"'linuxppc-embedded '" <linuxppc-embedded@lists.linuxppc.org>
References: <69BCCDDC980B4641BFC908D7BF95F1842A4B89@exchsrv-eng>
Subject: Re: execve system call question
Date: Wed, 27 Feb 2002 10:41:18 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


RE: execve system call questionHi Subhachandra Chandra.

> It could be that your ld.so* does not have execute >permissions. The 2.4.2 and 2.4.4 kernels did not care >about this but the 2.4.17 cares about it. I do not know >when the actual switchover happened.  Since you are >doing NFS there may be other files which have incorrect >permissions.

ld.so* has execute permission.
I will try 2.4.2 then.

Thank you.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
