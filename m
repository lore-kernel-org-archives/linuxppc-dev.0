Return-Path: <kkboyanov@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.232])
	by ozlabs.org (Postfix) with ESMTP id 95924DDE3C
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Aug 2007 18:40:04 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 71so901304wri
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Aug 2007 01:40:03 -0700 (PDT)
Message-ID: <929bf310708200140w6efc57f6k81a1339845059e2d@mail.gmail.com>
Date: Mon, 20 Aug 2007 10:40:03 +0200
From: "Konstantin Boyanov" <kkboyanov@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Driver for device behind a PCI-VME bridge
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_112948_14477232.1187599203373"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_112948_14477232.1187599203373
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi list,

I'm currently reading the LDD 3rd Edition and trying to create a device
driver for a custom device located on VME bus. I have already linux
2.6.15running on the master board, as well as the device driver for
the PCI-VME
bridge. The main problem I have is understanding how to "attach" my driver
for the custom device to the bridge device driver.
The bridge device driver is implemented as a class, i.e. doesn't define a
new bus type. Should I define a new class for my driver, or should I connect
it somehow to the existing one (maybe by something as "subclass")?
All I want to do is to redirect I/O reads and writes to the VME bus, but I
got no clue as to how to use the existing VME bridge driver for this
purpose. After I get through this I think all other things (VME interrupt
registration & handling, etc.) will be straightforward.
The LDD 3rd book states that defining a new bus type is the last thing one
would like to do, instead defining a class is far better approach. Why is
that?

Any recommendations and sharing of practical experience are highly
appreciated.

Best Regards,
Konstantin

------=_Part_112948_14477232.1187599203373
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi list,<br><br>I&#39;m currently reading the LDD 3rd Edition and trying to
create a device driver for a custom device located on VME bus. I have
already linux 2.6.15 running on the master board, as well as the device
driver for the PCI-VME bridge. The main problem I have is understanding
how to &quot;attach&quot; my driver for the custom device to the bridge device
driver.
<br>The bridge device driver is implemented as a class, i.e. doesn&#39;t
define a new bus type. Should I define a new class for my driver, or
should I connect it somehow to the existing one (maybe by something as
&quot;subclass&quot;)?<br>All I want to do is to redirect I/O reads and writes to the VME bus, but I got no clue as to how to use the existing VME bridge driver for this purpose. After I get through this I think all other things (VME interrupt registration &amp; handling, etc.) will be straightforward.
<br>The LDD 3rd book states that defining a new bus type is the last
thing one would like to do, instead defining a class is far better
approach. Why is that?<br><br>Any recommendations and sharing of practical experience are highly appreciated.
<br><br>Best Regards,<br><span class="sg">Konstantin</span>

------=_Part_112948_14477232.1187599203373--
