From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Armando Di Cianno" <armando@nycap.rr.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: titanium 800mhz revIII sleep
Date: Mon, 16 Sep 2002 14:51:41 +0200
Message-Id: <20020916125141.32195@192.168.4.1>
In-Reply-To: <200209131631.12013.armando@nycap.rr.com>
References: <200209131631.12013.armando@nycap.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>If bits for a working sleep are not in any kernel yet, but are being/plan to
>be worked on, I'll gladly offer my services and tibook as a test platform.
>
>... some days I really wish I knew how to hack kernel space. :-)

FAQ question unfortunately :(

ATI still didn't provide us with the necessary informations to get
the Radeon M7 to sleep properly, thus currently, if you try to
sleep, the video chip will just lock up.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
