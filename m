Date: Fri, 22 Oct 1999 23:50:47 -0400 (EDT)
From: "Mark S. Mathews" <mark@absoval.com>
To: Claude Robitaille <crobitaille@videotron.ca>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: NFS Root
In-Reply-To: <Pine.LNX.4.10.9910222227400.2741-100000@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.991022234956.11602A-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



For us, adding the no_root_squash option to the export usually fixes this
problem.

-Mark

On Fri, 22 Oct 1999, Claude Robitaille wrote:

> 
> Hi,
> 
> 
> I am trying to boot my MPC860 board via NFS-Root but I am getting
> a -13 error. The board did properly get its IP address from a bootp
> server. The server also provided the NFS server address, which the
> board properly use. I am able to mount the exported file system using
> another client (actually, the bootp server; I have 2 stations plus the
> 860 board).
> 
> Is there a good source of information on NFS other then the HOWTO. It
> seems a little bit outdated (early 1997); I am using 2.2.12 with kernel
> NFS, etc. And it does not rely help in troubleshooting (i.e. what is
> error -13?)
> 
> Thanks
> 
> Claude
> 
> 


Mark S. Mathews

AbsoluteValue Software     Web:    http://www.absoval.com
P.O. Box 941149            e-mail: mark@absoval.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
