From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B23621@penguin.adic.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Status of 440GP support?
Date: Fri, 24 Jan 2003 10:13:16 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello again,

I'm trying to get an ebony board up and running using various howtos found @
penguinppc.org and this mailing list. I saw some dialogue a while back
regarding 440GP support, but never any real conclusion to the discussion.

Can someone confirm the following:

1) After looking at the source tree for linuxppc_2_4 and linuxppc_2_4_devel,
it appears that 440GP support is only in linuxppc_2_4_devel. Does
linuxppc2_4_devel mean "unstable", or is it simply the latest and greatest
ppc kernel code for the 2.4 series that is stable.

2) I'm going through iterations of make menuconfig  (on linuxppc_2_4_devel
tree) to try and get a kernel for the 440GP successfully built and am not
having much success. Does anyone have a ".config" file that works that I
could take a look at? Should it compile out of the box? I set up my
cross-compile tools using the following:
  -> binutils-2.12.90.0.12
  -> gcc-3.2.1 (with gcc-3.2-crossppc.diff patch applied)

3) I plan to use 'Das U-Boot' as my boot loader. Any other snafus/gotchas
anyone would be willing to let me in on ahead of time??

Thanks,

-- Brian

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
