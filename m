Message-ID: <00d201c14ce5$069d5300$7e7e7e7e@server>
From: "RSR - Piero Dominioni" <pdominioni@rsr.it>
To: "Jean-Denis Boyer" <jdboyer@mediatrix.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <F1BED55F35F4D3118C0F00E0295CFF4D414C24@mail.mediatrix.com>
Subject: R: NFS mount for TQM823L
Date: Thu, 4 Oct 2001 16:58:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Be sure that the file '/etc/services' in the target includes the following
> entries:
>  sunrpc   111/tcp   portmapper   # RPC 4.0 portmapper TCP
>  sunrpc   111/udp   portmapper   # RPC 4.0 portmapper UDP

> Also, be sure you have the file '/etc/rpc' present in the target.

Dear Jean-Denis,
I must be pretty unlucky or a bit stupid since I couldn't remote-mount
my target filesystem yet!
I followed your instuctions: effectively I had neither the entries shown
above nor rpc file on my target.
Trying to do the best I copied the /etc/rpc file from the host to
the target: the problem is not solved yet.
We cross-compiled 'rpcinfo' command, but running it on the target
we obtain:

rpcinfo: can't contact portmapper: RPC: remote system error - Invalid
argument

While if we remote-execute it with
# rpcinfo -p 126.126.126.107  (our target's IP)
from the host's command line prompt we correctly obtain
program    vers    proto    port
100000        2        tcp        111    portmapper
100000        2        udp       111    portmapper

(Running the rpcinfo command on the host, it shows mountd
and nfsd ports too...)
Once again if we try '# ./mountd' we obtain

Cannot register service: RPC: Unable to send, errno = Invalid argument

At this point I can only make suppositions.
There is very little information about portmapper in all the documentation,
books and HOWTOs I looked in, and I read about a 'RPC server'.
Nevertheless I could find no remainders to it looking around
on my PC Linux Box nor something similar.
Is there a RPC server that I didn't start yet?
I feel not yet desperate, but this fight is exhausting...!
Thank you very much for your help.

Best regards.

Piero Dominioni
R.S.R. srl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
