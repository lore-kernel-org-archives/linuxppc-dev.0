Date: Thu, 13 Jan 2000 20:39:02 +0000
From: David Riley <happyoscar42@usa.net>
Subject: Re: CodeWarrior objects -> LinuxPPC
To: Greg Allen <gallen@arlut.utexas.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Reply-to: happyoscar42@usa.net
Message-id: <387E37D3.EF6D77C1@usa.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <v04011700b4a419989df1@[129.116.196.236]>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Greg Allen wrote:
> 
> Is it possible compile C source in CodeWarrior and create an object (or
> library) that can be used under LinuxPPC?

> I notice that a CW "Shared Library" is recognized by /usr/bin/file as
> "header for PowerPC PEF executable", but objdump will have nothing to do
> with it.
> 
> My initial guess is "not yet".  Has anyone else ever tried this?
> 
> I guess there's no reason that objcopy couldn't be extended to handle this
> (assuming CodeWarrior's object/lib file formats are public info).

My guess is that it is difficult if not impossible to use a MacOS
library (PowerPC or not) in linux, since even libraries make use of the
"cfrg" resource.  And Metrowerks' object format is proprietary (this is
one of the things that causes the major rift between CW and MPW).

-- 
"Your mouse has been moved.  Windows 95 must be restarted for change to
take effect."

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
