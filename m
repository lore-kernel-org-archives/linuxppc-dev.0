From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14837.11341.207379.903189@argo.linuxcare.com.au>
Date: Tue, 24 Oct 2000 17:29:33 +1100 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.2.18-pre17 candidate
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have been hacking on the 2.2 kernels for the last day or so.  I have
backported the ADB HID stuff so that you can use either the input
layer for ADB keyboards and mice, or the old mac_keyb.c and adbmouse.c
drivers.

To use the input layer, you currently need to say yes to the 'Support
for USB' and 'USB HID' questions and either (or both) of the 'Keyboard
support' and 'Mouse support' questions (CONFIG_INPUT_KEYBDEV and
CONFIG_INPUT_MOUSEDEV).  Then it will ask 'Use input layer for ADB
keyboard and mouse'.

If you say Y you get ADB keyboards and mice handled by the input
layer.  If you say N it will ask 'Support for ADB keyboard (old
driver)' and 'Support for ADB mouse (old driver)'.

The tree is available by anonymous rsync from these two sites:

penguinppc.org::linux-pmac-stable
ppc.linuxcare.com::linux-pmac-stable

I'll be interested to hear how people go with it.  I'll check the
changes into the bitkeeper linuxppc_2_2 tree within the next day or
so.  If it goes OK I'll send the patch to Alan for inclusion in
2.2.18.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
