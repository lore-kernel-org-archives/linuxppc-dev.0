Date: Wed, 4 Oct 2000 10:14:07 -0700
From: Kevin Buettner <kev@primenet.com>
Message-Id: <1001004171407.ZM31953@saguaro.lan>
In-Reply-To: Michael Norton <mnorton@cisco.com>
        "Purify or Comparable???" (Oct  4,  5:44am)
References: <39DAFC02.52938515@cisco.com>
To: mnorton@cisco.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: Purify or Comparable???
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Oct 4,  5:44am, Michael Norton wrote:

> What software tool is recommended for examining memory leaks in code?
> Does a close cousin of Purify exist for LinuxPPC/ What do you coders
> recommend?

I've never used Purify, so I can't offer a comparison, but...

I've found that dmalloc works quite well for debugging memory
allocation related problems.  See http://dmalloc.com/.

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
