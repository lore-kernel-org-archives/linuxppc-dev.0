Message-ID: <37727221.211AEEFD@alexa.com>
Date: Thu, 24 Jun 1999 11:00:01 -0700
From: joshua@alexa.com (Joshua Winsor)
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Mount Partitions on CDs
Content-Type: multipart/alternative;
 boundary="------------3BE66D0F3F46418CF403C980"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



--------------3BE66D0F3F46418CF403C980
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Since the user list wasn't able to give me any help I figured I'd see if
the dev group could

I have some CDRoms which have more than one partition, if I do a pdisk
/dev/scd0 with these disks in the drive I get a list of partitions with
their partition type,  however if I do a 'mount -t ufs -o type=openstep
/dev/scd0 /mnt/cdrom' my machine crashes (I have successfully mounted
other ufs partitions which are on hard disk).  I can mount the hfs
partition by simply doing 'mount -t hfs /dev/scd0 /mnt/cdrom', but the
openstep partition seems to be lost.

Is there anyway to get the CDRom to appear as a normal device or to be
able to get the other partitions off the CDRom so that I could mount
them as a loopback device?



--------------3BE66D0F3F46418CF403C980
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
<tt>Since the user list wasn't able to give me any help I figured I'd see
if the dev group could</tt><tt></tt>
<p><tt>I have some CDRoms which have more than one partition, if I do a
pdisk /dev/scd0 with these disks in the drive I get a list of partitions
with their partition type,&nbsp; however if I do a 'mount -t ufs -o type=openstep
/dev/scd0 /mnt/cdrom' my machine crashes (I have successfully mounted other
ufs partitions which are on hard disk).&nbsp; I can mount the hfs partition
by simply doing 'mount -t hfs /dev/scd0 /mnt/cdrom', but the openstep partition
seems to be lost.</tt><tt></tt>
<p><tt>Is there anyway to get the CDRom to appear as a normal device or
to be able to get the other partitions off the CDRom so that I could mount
them as a loopback device?</tt>
<br><tt></tt>&nbsp;
<br>&nbsp;</html>

--------------3BE66D0F3F46418CF403C980--


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
