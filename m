Date: Fri, 28 Sep 2001 20:56:54 +0900 (JST)
Message-Id: <20010928.205654.730556547.t-matsuu@protein.osaka-u.ac.jp>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: broken symlinks
From: MATSUURA Takanori <t-matsuu@protein.osaka-u.ac.jp>
In-Reply-To: <20010927.163320.846962931.t-matsuu@protein.osaka-u.ac.jp>
References: <20010927.163320.846962931.t-matsuu@protein.osaka-u.ac.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


More information of this problem.

NFS version of my LinuxPPC is 3.

I think this is NFS server-side problem. When I downgraded my LinuxPPC
kernel of NFS Server from 2.4.10 to 2.4.10-pre2, the problem does not
occured.


MATSUURA Takanori @ Division of Protein Chemistry,
                     Institute for Protein Research, Osaka University, Japan
E-Mail: t-matsuu@protein.osaka-u.ac.jp
Web Page: http://chux1.protein.osaka-u.ac.jp/~t-matsuu/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
