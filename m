Date: Wed, 2 Aug 2000 09:07:50 -0700 (PDT)
From: howarth@bromo.med.uc.edu (Jack Howarth)
Message-Id: <200008021607.JAA13404@bromo.med.uc.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC X Server
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kostas,
    So what will we end up when we build 4.0.1 using those patches you
provided today? Will we gain any dri acceleration on the r128 driver?
Or will we still need to apply additional patches for that. I am
still a tad confused about exactly how dependent the DRI code is in
4.0.1 on AGPgart. I am assuming if you set the AGPgart flag to NO
in host.def then DRI will be built without any code requiring AGPgart
to be available. Or am I misunderstanding the situation. I think
I will try building the dri modules tonight and see what happens in
the Mesa gears demo since that benchmarks framerate. Do you know what
additional lines have to be added into XF86Config to enable the DRI
modules? Thanks in advance.
                  Jack

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
