Date: Wed, 20 Nov 2002 13:03:12 -0800
Mime-Version: 1.0 (Apple Message framework v548)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: pmac_halt() bug
From: Tim Seufert <tas@mindspring.com>
To: linuxppc-dev@lists.linuxppc.org
Message-Id: <7AFDCF4E-FCCB-11D6-8F24-003065F22EAA@mindspring.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In platforms/pmac_setup.c, pmac_halt() is defined as follows:

pmac_halt(void)
{
     pmac_power_off();
}

Arguably, this is a bug because there should be a distinction between
halt and poweroff.  I've seen posts on user mailing lists from at least
two different people who want to halt without actually powering off,
but cannot do so because of this bug.  (I think the reasons have
something to do with attempting to get their machines to turn back on
automatically when power is restored after a UPS-initiated shutdown.)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
