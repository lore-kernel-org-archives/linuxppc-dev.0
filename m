Date: Thu, 08 Feb 2001 18:59:13 +0100
From: Vincent Favre-Nicolin <Vincent.Favre-Nicolin@cryst.unige.ch>
Subject: Re: MESH not found with 2.4.1 on 7500
To: linuxppc-dev@lists.linuxppc.org
Message-id: <3A82DE71.AC266A31@cryst.unige.ch>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


    I don't know if that's related, but I have a 7300 and
also had some problem with the internal SCSI.

    The internal bus can do 10 Mo/s, so in 2.2 kernels I
always used this value instead of the default 5 Mo/s. Now
when I tried to use 2.4, I could not boot with the same
modification. The SCSI is well recognized (I don't have the
dmesg here), but when trying to read the disk it stopped by
saying something like /dev/sdb: READ capacity failed.

    I never had this with 2.2, and 2.4 with the default max
speed of 5 Mo/s works fine. Note that I mostly use another
disk on an UW Formac card, so it's not important to me.

--
Vincent Favre-Nicolin                http://www.unige.ch/crystal/favrev/
Laboratoire de Cristallographie      Phone: +41 (22) 702 60 79
24 quai Ernest-Ansermet
CH-1211 Geneva 4, Switzerland        Fax: +41 (22) 702 61 08


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
